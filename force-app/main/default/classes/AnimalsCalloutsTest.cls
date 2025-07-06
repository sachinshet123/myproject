@isTest
private class AnimalsCalloutsTest {
    @isTest
    private static void testMakeGetCallout() {
        //create a mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        //associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        //get method to test
        HttpResponse result = AnimalsCallouts.makeGetCallout();
        //verify mock response is not null
        Assert.areNotEqual(null, result, 'the callout returned a null response');
        //verify status code
        Assert.areEqual(200, result.getStatusCode(), 'the status code is not 200');
        //verify content type
        Assert.areEqual('application/json;charset=UTF-8', result.getHeader('Content-Type'), 'content type are not equal');
        //verify the array contains 3 items
        Map<String, Object> animalResult = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) animalResult.get('animals');
        Assert.areEqual(3, animals.size(), 'the array should only contain 3 values');
        Assert.areEqual('pesky porcupine', String.valueOf(animals[0]), 'First animal does not match');
		Assert.areEqual('hungry hippo', String.valueOf(animals[1]), 'Second animal does not match');
		Assert.areEqual('squeaky squirrel', String.valueOf(animals[2]), 'Third animal does not match');
    }
    @isTest
    private static void testMakePostCallout() {
        //set mock callout class. 
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        //this causes a fake response to be sent from the class that implements HttpCalloutMock
        HttpResponse response = AnimalsCallouts.makePostCallout();
        //verifies the response contains fake values
        String contentType = response.getHeader('Content-Type');
        Assert.areEqual('application/json', contentType, 'content type is not equal');
        String responseBody = response.getBody();
        String expectedValue = '{"animals": ["pesky porcupine", "hungry hippo", "squeaky squirrel", "mighty moose"]}';
        Assert.areEqual(expectedValue, responseBody, 'response body is not equal');
        Assert.areEqual(200, response.getStatusCode(), 'the status code is not 200');
        Assert.areNotEqual(null, response, 'the response is not null');
        
    }
}