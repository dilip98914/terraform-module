const { S3Client, PutObjectCommand, GetObjectCommand } = require("@aws-sdk/client-s3");

const s3 = new S3Client({
  region: process.env.AWS_REGION
});

const bucket = process.env.BUCKET_NAME;

exports.handler = async () => {
  const key = "test.txt";
  const content = "Hello from Lambda -> S3";

  await s3.send(
    new PutObjectCommand({
      Bucket: bucket,
      Key: key,
      Body: content
    })
  );

  const result = await s3.send(
    new GetObjectCommand({
      Bucket: bucket,
      Key: key
    })
  );

  const body = await result.Body.transformToString();

  console.log("S3 object content:", body);

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Successfully accessed S3",
      content: body
    })
  };
};