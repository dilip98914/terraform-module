exports.handler = async (event) => {
  console.log("Lambda invoked");

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello from Lambda"
    })
  };
};