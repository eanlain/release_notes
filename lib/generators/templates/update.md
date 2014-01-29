# <%= @app_name -%> <%= @release_version.gsub('_', '.') -%> Release Notes
#### <%= Time.now.utc.strftime('%m/%d/%Y') %>

<% if @message['overview'].length > 0 -%>
###### <%= @message['overview'] -%>

<% end -%>

<% if !@message['additions'].empty? -%>
Additions
----
<% @message['additions'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['changes'].empty? -%>
Changes
----
<% @message['changes'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['improvements'].empty? -%>
Improvements
----
<% @message['improvements'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['removals'].empty? -%>
Removals
----
<% @message['removals'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['fixes'].empty? -%>
Fixes
----
<% @message['fixes'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['bugs'].empty? -%>
Known Issues / Bugs
----
<% @message['bugs'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<% if !@message['upcoming'].empty? -%>
Upcoming
----
<% @message['upcoming'].each do |msg| -%>
* <%= msg -%>

<% end -%>
<% end -%>

<em>the end</em>