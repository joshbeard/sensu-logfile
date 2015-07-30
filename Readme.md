# Sensu Logfile Handler

This is a Sensu handler for writing event notifications to a file. This is
intended for testing Sensu alerts.

## Configuration

There's only one option:

#### `file`

Absolute path to the file to write events to

__Example:__

```json
{
  "logfile": {
    "file": "/tmp/sensu-events.log"
  }
}
```

You can also pass this on the command line via `-f` or `--file`

## Example Output

```
2015-07-30 20:23:06 +0000
         Host: host01
      Address: 10.2.1.11
    Timestamp: 2012-01-12 17:42:49 +0000
        Check: frontend_http_check
       Output: HTTP CRITICAL: HTTP/1.1 503 Service Temporarily Unavailable
       Status: 2
      Command: check_http -I 127.0.0.1 -u http://web.example.com/healthcheck.html -R 'pageok'
  Occurrences: 1
       Action: create
     Interval: 60
-------------------------------------------------------------------------------
```

## Testing

You can test the plugin by piping event data to it.

Refer to [https://sensuapp.org/docs/0.12/events](https://sensuapp.org/docs/0.12/events)
for sample data.  Then do something like:

```shell
cat sample.json | logfile.rb
```
