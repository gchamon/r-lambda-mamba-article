FROM public.ecr.aws/lambda/python:3.9

# the lambda handler
COPY lambda.py ${LAMBDA_TASK_ROOT}

CMD ["lambda.handler"]

