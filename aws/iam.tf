resource "aws_iam_user" "obsidian_til" {
  name = "obsidian_til"
  path = "/system/"
}

resource "aws_iam_access_key" "obsidian_til" {
  user    = aws_iam_user.obsidian_til.name
  pgp_key = "keybase:miroscular"
}

data "aws_iam_policy_document" "s3limitedAccess" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
    ]

    resources = [
      aws_s3_bucket.obsidian_til.arn,
      "${aws_s3_bucket.obsidian_til.arn}/*",
    ]
  }
}

resource "aws_iam_policy" "s3limitedAccess" {
  name        = "s3limitedAccess"
  description = "Provides full access to obsidian vault S3 bucket"
  policy      = data.aws_iam_policy_document.s3limitedAccess.json
}

resource "aws_iam_user_policy_attachment" "obsidian_til" {
  user       = aws_iam_user.obsidian_til.name
  policy_arn = aws_iam_policy.s3limitedAccess.arn
}

output "obsidian_til" {
  description = "The access key id"
  value       = aws_iam_access_key.obsidian_til.id
  sensitive   = true
}

output "obsidian_til_access_key" {
  description = "The gpg encrypted secret access key"
  value       = aws_iam_access_key.obsidian_til.encrypted_secret
  sensitive   = true
}
