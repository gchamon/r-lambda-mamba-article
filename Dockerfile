FROM public.ecr.aws/lambda/python:3.9

# the lambda handler
COPY . ${LAMBDA_TASK_ROOT}

CMD ["lambda_handler.handler"]

