extends Node

var server: UDPServer
var server_port = 4242 # No magic numbers

func _ready() -> void: 
	server = UDPServer.new()
	server.listen(server_port)

func _process(_delta: float) -> void:
	server.poll()
	if server.is_connection_available():
		var peer: PacketPeerUDP = server.take_connection()
		var packet = peer.get_packet()
		print("Received: '%s' %s:%s" % [packet.get_string_from_utf8(), peer.get_packet_ip(), peer.get_packet_port()])
		
		peer.put_packet("Hello from Godot!".to_utf8_buffer())
