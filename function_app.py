import azure.functions as func
import datetime
import json
import logging

app = func.FunctionApp()

@app.route(route="hello", auth_level=func.AuthLevel.ANONYMOUS)
def hello(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')
    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(json.dumps(dict(message=f"Hello, {name}")), 
                                 status_code=200,
                                 mimetype='application/json')
    else:
        return func.HttpResponse(json.dumps(dict(message=f"Hello, YOU!!!")), status_code=200)
