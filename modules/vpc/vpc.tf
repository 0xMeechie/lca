//Main vpc creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-vpc",
  }

}
// Three tier subnet creation. One for public traffic, one for our services 
// and one for our data. 
resource "aws_subnet" "public" {
  for_each          = local.public_subnet_cidr_list
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    Name = "${var.environment}-public-${each.key}"
  }
  map_public_ip_on_launch = true

}

resource "aws_subnet" "service" {
  for_each          = local.service_subnet_cidr_list
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    Name = "${var.environment}-service-${each.key}"
  }
  map_public_ip_on_launch = false

}

resource "aws_subnet" "data" {
  for_each          = local.data_subnet_cidr_list
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key
  tags = {
    Name = "${var.environment}-data-${each.key}"
  }
  map_public_ip_on_launch = false

}

// IGW for all public traffic 

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-IGW"
  }

}

// Nat gateway. High AZ so we are going to have one in
// each of the public subnet
// but we will need to create three EIP for each of them.


resource "aws_eip" "nat" {
  for_each = toset(var.azs)

  domain = "vpc"

  depends_on = [aws_internet_gateway.main]

  tags = {
    Name = "${each.value}-ngw-eip"
  }
}

resource "aws_nat_gateway" "main" {

  for_each = local.public_subnet_cidr_list


  subnet_id         = aws_subnet.public[each.key].id
  allocation_id     = aws_eip.nat[each.key].id
  connectivity_type = "public"

  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-${each.key}-ngw"
  }


  depends_on = [aws_internet_gateway.main]

}


// Route Table. Public and private 

resource "aws_route_table" "public" {
  for_each = local.public_subnet_cidr_list
  vpc_id   = aws_vpc.main.id


  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-${each.key}-public"
  }
}

resource "aws_route" "igw" {
  for_each               = local.public_subnet_cidr_list
  route_table_id         = aws_route_table.public[each.key].id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }

}

resource "aws_route_table" "private" {
  // using the data subnets here but doesnt matter
  for_each = local.data_subnet_cidr_list
  vpc_id   = aws_vpc.main.id


  tags = {
    Name = "${aws_vpc.main.tags["Name"]}-${each.key}-private"
  }
}

resource "aws_route" "private" {
  // using the data subnets here but doesnt matter
  for_each               = local.data_subnet_cidr_list
  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = aws_nat_gateway.main[each.key].id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }

}

resource "aws_route_table_association" "public" {
  for_each       = local.public_subnet_cidr_list
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = aws_subnet.public[each.key].id
  timeouts {
    create = "5m"
  }


}

resource "aws_route_table_association" "data" {
  for_each       = local.data_subnet_cidr_list
  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = aws_subnet.data[each.key].id
  timeouts {
    create = "5m"
  }


}

resource "aws_route_table_association" "service" {
  for_each       = local.service_subnet_cidr_list
  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = aws_subnet.service[each.key].id
  timeouts {
    create = "5m"
  }


}















