local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s({ trig = "wg-server", desc = "Wireguard server config" }, {
		t({ "[Interface]", "" }),
		t({ "Address = 10.0.0.1/24", "" }),
		t({ "ListenPort = 51820", "" }),
		t({ "PrivateKey = ", "" }),
		t({ "PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE", "" }),
		t({
			"PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE",
			"",
		}),
		t({ "", "" }),
		t({ "[Peer]", "" }),
		t({ "PublicKey = ", "" }),
		t({ "AllowedIPs = 10.0.0.2/32", "" }),
		t({ "", "" }),
		t({ "[Peer]", "" }),
		t({ "PublicKey = ", "" }),
		t({ "AllowedIPs = 10.0.0.3/32", "" }),
	}),
	s({ trig = "wg-client", desc = "Wireguard client config" }, {
		t({ "[Interface]", "" }),
		t({ "Address = 10.0.0.2/24", "" }),
		t({ "ListenPort = 51820", "" }),
		t({ "PrivateKey = ", "" }),
		t({ "", "" }),
		t({ "[Peer]", "" }),
		t({ "PublicKey = ", "" }),
		t({ "AllowedIPs = 0.0.0.0/0, ::/0", "" }),
		t({ "Endpoint = myserver.dyndns.org:51820", "" }),
	}),
}
