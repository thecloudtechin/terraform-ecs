resource "aws_key_pair" "serverkey" {
  key_name   = "serverkey"
  public_key = file("serverkey.pub")

}