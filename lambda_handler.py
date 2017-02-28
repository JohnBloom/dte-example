from downtoearth.router import Router

from routes import ROUTE_MAP

def handle_event(event, context):
    """Route and handle incoming event."""
    print("Executing...")
    router = Router(ROUTE_MAP)
    return router.route_request(event, context)
