public class CalculatorCalloutMock implements WebServiceMock {
    public void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNamespace,
        String responseName,
        String responseType
    ) {
        if (request instanceof calculatorServices.doAdd) {
            calculatorServices.doAddResponse res = new calculatorServices.doAddResponse();
            res.return_x = ((calculatorServices.doAdd) request).arg0 + ((calculatorServices.doAdd) request).arg1;
            response.put('response_x', res);
        } else if (request instanceof calculatorServices.doSubtract) {
            calculatorServices.doSubtractResponse res = new calculatorServices.doSubtractResponse();
            res.return_x = ((calculatorServices.doSubtract) request).arg0 - ((calculatorServices.doSubtract) request).arg1;
            response.put('response_x', res);
        } else if (request instanceof calculatorServices.doMultiply) {
            calculatorServices.doMultiplyResponse res = new calculatorServices.doMultiplyResponse();
            res.return_x = ((calculatorServices.doMultiply) request).arg0 * ((calculatorServices.doMultiply) request).arg1;
            response.put('response_x', res);
        } else if (request instanceof calculatorServices.doDivide) {
            calculatorServices.doDivideResponse res = new calculatorServices.doDivideResponse();
            if (((calculatorServices.doDivide) request).arg1 != 0) {
                res.return_x = ((calculatorServices.doDivide) request).arg0 / ((calculatorServices.doDivide) request).arg1;
            } else {
                res.return_x = 0; // Mocking zero division case
            }
            response.put('response_x', res);
        }
    }
}