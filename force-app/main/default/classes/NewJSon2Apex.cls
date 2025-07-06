public class NewJSon2Apex {
    public String country_code {get; set;}
    public String country_prefix {get; set;}
    public String country_name {get; set;}
    public String international_format {get; set;}
    public String location {get; set;}
    public String local_format {get; set;}
    public String carrier {get; set;}
    public String number_Z {get; set;}
    public String line_type {get; set;}
    public Boolean valid {get; set;}

    public NewJSon2Apex(System.JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'valid') {
                        valid = parser.getBooleanValue();
                    } else if (text == 'number') {
                        number_Z = parser.getText();
                    } else if (text == 'local_format') {
                        local_format = parser.getText();
                    } else if (text == 'international_format') {
                        international_format = parser.getText();
                    } else if (text == 'country_prefix') {
                        country_prefix = parser.getText();
                    } else if (text == 'country_code') {
                        country_code = parser.getText();
                    } else if (text == 'country_name') {
                        country_name = parser.getText();
                    } else if (text == 'location') {
                        location = parser.getText();
                    } else if (text == 'carrier') {
                        carrier = parser.getText();
                    } else if (text == 'line_type') {
                        line_type = parser.getText();
                    } else {
                        System.debug(LoggingLevel.WARN, 'JSon2Apex consuming unrecognized property: ' + text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }

    public static NewJSon2Apex parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return new NewJSon2Apex(parser);
    }

    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
}