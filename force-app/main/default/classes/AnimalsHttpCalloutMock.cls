@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock {
    //implement respond interface method
    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["pesky porcupine", "hungry hippo", "squeaky squirrel", "mighty moose"]}');
        response.setStatusCode(200);
        return response;
    }

}