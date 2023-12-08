module twilio

import encoding.base64
import net.http
import net.urllib
import json

struct TwilioClient {
	api_version string = '2010-04-01'
	account_sid string
	auth_token  string
	from_number string
}

struct TwilioResponse {
	account_sid           string
	api_version           string
	body                  string
	date_created          string
	date_sent             ?string
	date_updated          ?string
	direction             string
	error_code            ?string
	error_message         ?string
	from                  string
	messaging_service_sid string
	num_media             string
	num_segments          string
	price                 ?string
	price_unit            ?string
	sid                   string
	status                string
	subresource_uris      map[string]string
	to                    string
	uri                   string
}

// Method to send an SMS using Twilio
fn (client TwilioClient) fetch_sms(sid string) !TwilioResponse {
	// Encode credentials for Basic Auth
	credentials := '${client.account_sid}:${client.auth_token}'.bytes()
	encoded_credentials := base64.encode(credentials)

	// Twilio API URL for fetching SMS
	twilio_url := 'https://api.twilio.com/${client.api_version}/Accounts/${client.account_sid}/Messages/${sid}.json'

	// Create the request with headers and body
	request := http.FetchConfig{
		method: .get
		url: twilio_url
		header: http.new_header_from_map({
			http.CommonHeader.authorization: 'Basic ${encoded_credentials}'
		})
	}

	// Making the POST request to Twilio API
	response := http.fetch(request) or { return error('Failed to send SMS: ${err}') }

	// Parse the JSON response
	twilio_response := json.decode(TwilioResponse, response.body) or {
		return error('Failed to parse Twilio response: ${err}')
	}

	return twilio_response
}

// Method to send an SMS using Twilio
fn (client TwilioClient) send_sms(to string, body string) !TwilioResponse {
	// Encode credentials for Basic Auth
	credentials := '${client.account_sid}:${client.auth_token}'.bytes()
	encoded_credentials := base64.encode(credentials)

	// Twilio API URL for sending SMS
	twilio_url := 'https://api.twilio.com/${client.api_version}/Accounts/${client.account_sid}/Messages.json'

	// Manually create form data as URL-encoded string
	encoded_to := urllib.query_escape(to)
	encoded_from := urllib.query_escape(client.from_number)
	encoded_body := urllib.query_escape(body)
	encoded_form_data := 'To=${encoded_to}&From=${encoded_from}&Body=${encoded_body}'

	// Create the request with headers and body
	request := http.FetchConfig{
		method: .post
		url: twilio_url
		header: http.new_header_from_map({
			http.CommonHeader.authorization: 'Basic ${encoded_credentials}'
			http.CommonHeader.content_type:  'application/x-www-form-urlencoded'
		})
		data: encoded_form_data
	}

	// Making the POST request to Twilio API
	response := http.fetch(request) or { return error('Failed to send SMS: ${err}') }

	// Parse the JSON response
	twilio_response := json.decode(TwilioResponse, response.body) or {
		return error('Failed to parse Twilio response: ${err}')
	}

	return twilio_response
}
