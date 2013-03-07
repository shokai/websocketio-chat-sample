WebSocketIO.on :chat do |data, from|
  puts "#{data['name']} : #{data['message']}  (from:#{from})"
  WebSocketIO.push :chat, data
end

WebSocketIO.on :connect do |session|
  puts "new client <#{session}>"
  WebSocketIO.push :chat, {:name => "system", :message => "new client <#{session}>"}
  WebSocketIO.push :chat, {:name => "system", :message => "welcome <#{session}>"}, {:to => session}
end

WebSocketIO.on :disconnect do |session|
  puts "disconnect client <#{session}>"
  WebSocketIO.push :chat, {:name => "system", :message => "bye <#{session}>"}
end

EM::defer do
  loop do
    WebSocketIO.push :chat, :name => 'clock', :message => Time.now.to_s
    sleep 60
  end
end

get '/' do
  haml :index
end

get '/:source.css' do
  scss params[:source].to_sym
end
