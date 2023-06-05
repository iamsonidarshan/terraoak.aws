# ---------------------------------------------------------------------
# SecurityGroup
# ---------------------------------------------------------------------
resource "aws_security_group" "sac_security_group" {
  # oak9: Define asset inventory tags
  name                   = "sac-security-group"
  description            = "Allow TLS inbound traffic"
  vpc_id                 = aws_vpc.security_group_vpc.id
  revoke_rules_on_delete = false

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
  }
}

# ---------------------------------------------------------------------
# VPC
# ---------------------------------------------------------------------
resource "aws_vpc" "security_group_vpc" {
  # oak9: Define asset inventory tags
  cidr_block = "10.0.0.0/16" 
}