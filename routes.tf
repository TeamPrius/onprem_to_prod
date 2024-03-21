# Routes public subnet on prem to nonprod

# Routes public subnet on prem to prod

resource "aws_route" "onprem_to_prod" {

    route_table_id      = "${aws_route_table.onprem_transit_gateway_route.id}"

    destination_cidr_block  = "${aws_vpc.prod_vpc.cidr_block}"

    transit_gateway_id      = "${aws_ec2_transit_gateway.transit_gateway.id}"

}


# Routes prod to public subnet on prem

resource "aws_route" "prod_to_onprem" {

    route_table_id      = "${aws_route_table.transit_gateway_route.id}"

    destination_cidr_block  = "${aws_vpc.onprem.cidr_block}"

    transit_gateway_id      = "${aws_ec2_transit_gateway.transit_gateway.id}"

}

