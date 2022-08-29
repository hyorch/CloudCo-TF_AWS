resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins-server_ec2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "Jenkins_ec2-role"
  }
}

resource "aws_iam_instance_profile" "jenkins_ec2_profile" {
  name = "jenkins_ec2_profile"
  role = "${aws_iam_role.jenkins_ec2_role.name}"
}

resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"
  path        = "/"
  description = "s3 policy for Jenkins"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
  path        = "/"
  description = "EC2 policy for Jenkins. Allow create VPC elements"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [    
    {
      "Action": [
        "EC2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3-pol-attach" {
  role       = "${aws_iam_role.jenkins_ec2_role.name}"
  policy_arn = "${aws_iam_policy.s3_policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ec2-pol-attach" {
  role       = "${aws_iam_role.jenkins_ec2_role.name}"
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}