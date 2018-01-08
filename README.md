# form_example

Example showcasing usage of x-www-form-urlencoded in Jaguar.

![Screenshot](https://raw.githubusercontent.com/jaguar-examples/form_example/master/doc_files/screenshot.png)

# Try it

## Use pub to serve html files

```bash
pub serve --port 8000
```

## Start the server

```bash
dart bin/server.dart
```

## Try the example app on the browser

Open [http://localhost:8005](http://localhost:8005) in a browser of
your choice.

# Explanation

This example implements a "contacts list" web app to demonstrate how to
use x-www-form-urlencoded in Jaguar.

The interface to add a new contact is built using HTML forms. This form is
sent as x-www-form-urlencoded by the browser.

The server uses `bodyAsUrlEncodedForm` to decode the form.


