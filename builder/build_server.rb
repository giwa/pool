$:.unshift '/app/builder'

require 'em-websocket'
require 'pty'
require 'builder'

EM.run {
  EM::WebSocket.run(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"
      @git_commit_id = handshake.headers["Host"].split(".")[0]

      Thread.new(ws) do |ws|
        begin
          builder = Builder.new(ws, @git_commit_id)
          builder.up
        rescue => ex
          puts "#{ex.class}: #{ex.message}"
          ws.send "#{ex.class}: #{ex.message}"
        end
      end
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Recieved message: #{msg}"
      ws.send "Pong: #{msg}"
    }
  end
}
