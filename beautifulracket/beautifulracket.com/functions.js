function cancel_bubble(e) {
  // prevents click on hyperlink from propagating into clickable div behind it
  var evt = e ? e:window.event;
  if (evt.stopPropagation) {
    evt.stopPropagation();
  }
  if (evt.cancelBubble) {
    evt.cancelBubble = true;
  }
}




var default_comment_value = "comment"
var default_email_value = "email"

function make_edit_form(form_id) {
    var html = '<form class="feedback" id="form_id_x" onclick="cancel_bubble(event);"><div>link: <a href="path_x#my_id_x">protocol_x//host_xpath_x#my_id_x</a></div><input class="sendable" type="hidden" name="url" value="protocol_x//host_xpath_x#my_id_x"/><textarea class="sendable" name="comments" type="text" onfocus="clear_comment_field(this);">comment_value_x</textarea><div class="control_row"><input class="sendable" name="email" type="email" value="email_value_x" onfocus="clear_email_field(this);"/><input onclick="handle_submit(\'form_id_x\');return false;" type="submit" name="submit" value="send comment to author"/></div></form>';
    html = html.replace(/form_id_x/g, form_id);
    html = html.replace(/my_id_x/g, form_id.replace("form_", ""));
    html = html.replace(/protocol_x/g, location.protocol);
    html = html.replace(/host_x/g, location.host);
    html = html.replace(/comment_value_x/g, default_comment_value);
    html = html.replace(/email_value_x/g, default_email_value);
    html = html.replace(/path_x/g, location.pathname);
    return html;
}

function clear_field(field, default_val) {
  field.value = (field.value == default_val) ? "" : field.value;
}

function clear_comment_field(field) {
  clear_field(field, default_comment_value);
}

function clear_email_field(field) {
  clear_field(field, default_email_value);
}

function clear_email_signup_field(field) {
  field.value = "";
}

function set_cookie(cookie_name, value, days_until_expiration)
{
    var expiration_date = new Date();
    expiration_date.setDate(expiration_date.getDate() + days_until_expiration);
    var cookie_value = escape(value) + ((days_until_expiration == null) ? "" : "; expires=" + expiration_date.toUTCString());
    document.cookie = cookie_name + "=" + cookie_value + "; path=/";
}

function get_cookie(cookie_name) {
    var key_name = cookie_name + "=";
    var cookie_pairs = document.cookie.split(';');
    for(var i=0; i < cookie_pairs.length; i++) {
        var c = cookie_pairs[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(key_name) == 0) {
            return c.substring(key_name.length,c.length);
        }
    }
    return "";
}


function handle_submit(form_id) {
    var request = new XMLHttpRequest();
    var url = "http://beautifulracket.com/scripts/poster.rkt";
    var form = document.getElementById(form_id);
    var sendables = form.getElementsByClassName("sendable");
    var outer_scope = this;

    var url_encoded_data = "";

    var url_encoded_pairs = [];
    for (var i = 0 ; i < sendables.length ; i++) {
        // skip unchecked radio buttons
        if (sendables[i].type == "radio" && ! sendables[i].checked) continue;
        name = sendables[i].name || "untitled";
        value = sendables[i].value || "unvalued";
        if (name == "email" && value !== "unvalued") set_cookie("email", value, 30);
        url_encoded_pairs.push(encodeURIComponent(name) + '=' + encodeURIComponent(value));
    }

    url_encoded_data = url_encoded_pairs.join('&').replace(/%20/g, '+');

    request.open('POST', url, true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=UTF-8');
    request.setRequestHeader("Content-length", url_encoded_data.length);
    request.setRequestHeader("Connection", "close");

    request.onreadystatechange = function() {
      var self = outer_scope; // makes global var `document` available
      // good status = 200 when testing remotely; 0 when testing locally.
      // if running locally, `localhost` will appear in the url path
      var good_status = url_encoded_data.match(/localhost/) ? 0 : 200;
     if (request.readyState == 4 && request.status == good_status) {
        var form = document.getElementById(form_id);
        form.parentNode.removeChild(form);
        notify("Thank you for your comment");
      }
    }

    request.send(url_encoded_data);
}


function toggle_form(id) {
    form_id = "form_" + id;
    form = document.getElementById(form_id);
    if (! form) {
      document.getElementById(id).insertAdjacentHTML('beforeend', make_edit_form(form_id));
      form = document.getElementById(form_id); // load the new form
      var email_cookie_value = get_cookie("email");
      if (email_cookie_value) form.elements["email"].value = email_cookie_value;
    } else {
      // toggle visibility (so form contents are preserved)
      form.classList.toggle("js_hidden");
    }
}

function notify(msg, duration=2000) {
  alert_box = document.getElementById('alert');
  alert_box.innerHTML = msg;
  function toggle_alert() {alert_box.classList.toggle('visible');}
  toggle_alert();
  setTimeout(toggle_alert, duration);
}

function load_random_illo() {
  document.getElementById("polboxes").src="/img/polboxes"+Math.floor(Math.random() * 25)+".svg";
}