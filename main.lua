-- iLoseAgain1 Hub — Base64 loader (paste whole file as main.lua)
-- This file decodes a Base64 payload (the real GUI/script) and executes it.
-- Paste this exact content into your repo file (main.lua) and use your executor to run it.

local __b = [[
LS0g8J+MnyBWaWV0bmFtIFBpZWNlIFNpbXBsZSBHVUkgU2NyaXB0IPCfjJ8KLS0gVMOhYyBnaeG6ozogYuG6oW4gdsOgIENoYXRHUFQgdOG6oW8gY2h1bmcg8J+YjgoKLS0g8J+nqSBU4bqhbyBHVUkKbG9jYWwgU2NyZWVuR3VpID0gSW5zdGFuY2UubmV3KCJTY3JlZW5HdWkiLCBnYW1lLkNvcmVHdWkpClNjcmVlbkd1aS5OYW1lID0gImlMb3NlQWdhaW4xX1ZQX0h1YiIKU2NyZWVuR3VpLlJlc2V0T25TcGF3biA9IGZhbHNlCgpsb2NhbCBNYWluID0gSW5zdGFuY2UubmV3KCJGcmFtZSIsIFNjcmVlbkd1aSkKTWFpbi5TaXplID0gVURpbTIubmV3KDAsIDIzMCwgMCwgMzEwKQpNYWluLlBvc2l0aW9uID0gVURpbTIubmV3KDAuNSwgLTExNSwgMC41LCAtMTU1KQpNYWluLkJhY2tncm91bmRDb2xvcjMgPSBDb2xvcjMuZnJvbVJHQigyNSwgMjUsIDI1KQpNYWluLkFjdGl2ZSA9IHRydWUKTWFpbi5EcmFnZ2FibGUgPSB0cnVlCgpsb2NhbCBjb3JuZXIgPSBJbnN0YW5jZS5uZXcoIlVJQ29ybmVyIiwgTWFpbikKY29ybmVyLkNvcm5lclJhZGl1cyA9IFVEaW0ubmV3KDAsIDEwKQoKbG9jYWwgVGl0bGUgPSBJbnN0YW5jZS5uZXcoIlRleHRMYWJlbCIsIE1haW4pClRpdGxlLlNpemUgPSBVRGltMi5uZXcoMSwgMCwgMCwgMzUpClRpdGxlLlBvc2l0aW9uID0gVURpbTIubmV3KDAsIDAsIDAsIDApClRpdGxlLkJhY2tncm91bmRDb2xvcjMgPSBDb2xvcjMuZnJvbVJHQig1MCwgNTAsIDUwKQpUaXRsZS5Cb3JkZXJTaXplUGl4ZWwgPSAwClRpdGxlLlRleHQgPSAi4q2QIFZpZXRuYW0gUGllY2UgSHViIOKtkCIKVGl0bGUuVGV4dENvbG9yMyA9IENvbG9yMy5uZXcoMSwgMSwgMSkKVGl0bGUuRm9udCA9IEVudW0uRm9udC5Tb3VyY2VTYW5zQm9sZApUaXRsZS5UZXh0U2l6ZSA9IDE4ClRpdGxlLlRleHRTY2FsZWQgPSB0cnVlCgpsb2NhbCBmdW5jdGlvbiBjcmVhdGVCdXR0b24odGV4dCwgeSwgY2FsbGJhY2spCglsb2NhbCBiID0gSW5zdGFuY2UubmV3KCJUZXh0QnV0dG9uIiwgTWFpbikKCWIuU2l6ZSA9IFVEaW0yLm5ldygxLCAtMjAsIDAsIDMyKQoJYi5Qb3NpdGlvbiA9IFVEaW0yLm5ldygwLCAxMCwgMCwgeSkKCWIuQmFja2dyb3VuZENvbG9yMyA9IENvbG9yMy5mcm9tUkdCKDYwLCA2MCwgNjApCgliLlRleHRDb2xvcjMgPSBDb2xvcjMubmV3KDEsIDEsIDEpCgliLlRleHQgPSB0ZXh0CgliLkZvbnQgPSBFbnVtLkZvbnQuU291cmNlU2Fuc0JvbGQKCWIuVGV4dFNpemUgPSAxNgoJbG9jYWwgYyA9IEluc3RhbmNlLm5ldygiVUlDb3JuZXIiLCBiKQoJYy5Db3JuZXJSYWRpdXMgPSBVRGltLm5ldygwLCA2KQoJYi5Nb3VzZUJ1dHRvbjFDbGljazpDb25uZWN0KGNhbGxiYWNrKQoJcmV0dXJuIGIKZW5kCgotLSDimpnvuI8gQXV0byBNMSBDaWQgKHThu5FjIMSR4buZIDAuMXMpCmdldGdlbnYoKS5BdXRvTTEgPSBmYWxzZQpjcmVhdGVCdXR0b24oIvCfjIAgQXV0byBNMSBDaWQiLCA0NSwgZnVuY3Rpb24oKQoJZ2V0Z2VudigpLkF1dG9NMSA9IG5vdCBnZXRnZW52KCkuQXV0b00xCglwY2FsbChmdW5jdGlvbigpCgkJZ2FtZTpHZXRTZXJ2aWNlKCJTdGFydGVyR3VpIik6U2V0Q29yZSgiU2VuZE5vdGlmaWNhdGlvbiIsIHsKCQkJVGl0bGUgPSAiQXV0byBNMSIsCgkJCVRleHQgPSBnZXRnZW52KCkuQXV0b00xIGFuZCAi4Jqk4bq1ISAiIG9yICJHw6BuIHRhayEiLAoJCQlEdXJhdGlvbiA9IDIKCQkJfSkKCWVuZCkKCXRhc2suc3Bhd24oZnVuY3Rpb24oKQoJICAgIHdoaWxlIGdldGdlbnYoKS5BdXRvTTEgZG8KCQkJdGFzay53YWl0KDAuMSkKCQkJcGNhbGwoZnVuY3Rpb24oKQkKCQkJICAgICAgbG9jYWwgdG9vbCA9IGdhbWUuUGxheWVycy5Mb2NhbFBsYXllcjoKICAgICAgICAgICAgaWYgdG9vbCB0aGVuCgkJCQkJCWZvciBfLCBvYmogIGluIHBhaXJzKHRvb2w6R2V0RGVzY2VuZGFudHMoKSkgZG8KCQkJCQkJICAgICAgICAgICAgICAgIGlmIG9iai5Jc0EoIlJlbW90ZUV2ZW50IikgYW5kIG9iai5OYW1lOmxvd2VyKCk6ZmluZCgiaGl0Ym94IikgdGhlbgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpc1RvT29sPT0gIiVDaWQiIiAgICB3aGkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9ian0gZW5kCiAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kCiAgICAgICAgICAgICAgICAgICAgICAgIGVuZAoJICAgICAgICAgIGVuZAoJZW5kKQllbmQpCgl9KQplbmQpCgoKLS0g4p2MIMSQw7NuZyBHVUkgS2FpZG8gUXVlc3QgLS0KLS0gKGEpCgpjcmVhdGVCdXR0b24oIuKdlzEn4bqkIFV0byBLYWlkbyBRdWVzdCIpLCw4NSwKICAgIGZ1bmN0aW9uKCkKICAgICAgICBsY2xvZA09IGdhbWU6R2V0U2VydmljZSgicmVwbGljYXRlZFBhY2thZ2UiKQogICAgICAgIGlmIGNsYWRvIGFuZCBjIC5GdW5jKCkKS2NpQ29tbUZzOmZpcmVTZXJmZXIoImtBSURPVVUgUVVFTVFRUIiIpCkVuZAoKLS0g4pyK4p2kIEtoYW5oIER1eSAxCgpjcmVhdGVCdXR0b24oIuKlgqBBdXRvIEtoYW5oIER1eSAxIiwxMjUsZnVuY3Rpb24oKQogICAgcGNhbGwoZnVuY3Rpb24oKQogICAgICAgIGxvYWRzdHJpbmcoZ2FtZTpIdHRwR2V0KCIgaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2h1eW5odGhpbmdvY21haS9TaWtpYmlkaS9yZWZzL2hlYWRzL21haW4vRHV5aHViIikpKCkKICAgICAgICBlbmQpCmVuZCkKCgotLSDimqEgS2jDoW5oIER1eSAyCgpjcmVhdGVCdXR0b24oIuKlgqBBdXRvIEtoYW5oIER1eSAyIiwxNjUsZnVuY3Rpb24oKQogICAgcGNhbGwoZnVuY3Rpb24oKQogICAgICAgIGxvYWRzdHJpbmcoZ2FtZTpIdHRwR2V0KCgiaHR0cHM6Ly9yYXcuZ2l0aHVidXNlcmNvbnRlbnQuY29tL2R1eXNpcmE1L0dvenRvZy9yZWZzL2hlYWRzL21haW4vb2JmdXNjYXRlZF9zY3JpcHQtMTc1NDcxNjk1NDk4OC5sdWEudHh0IikpKCkKICAgICAgICBlbmQpCmVuZCkKCgotLSDinYwgS2lsbCBBdXJhIFBsYXllciAoZ2nhu68gbmd1ecOqbiDEkW/huqFuKQp1c2VyX2RhdGEgPSB7fQpncG9wID0KZ2V0Z2VudCgpLktpbGxBdXJhID0gZmFsc2UKY3JlYXRlQnV0dG9uKCdcdSIqIEtpbGwgQXVyYSBQbGF5ZXIgJycsIDIwNSwgZnVuY3Rpb24oKQpAY29yZGVkPCsKZW5kCgpMb2NhdG9yID0gJ3dhcicsIHBsYUXQ9CmltcG9ydCBpLgpAbmV3CgpzZW5kRm9yKClcbi0tIFRoaXMgaXMgYSBob29rcyBkYXRhCgpzaW1wbGUgYnVpbHQgZGVjb2RlIGZ1bmN0aW9uCmVuZCk=
]]

-- robust base64 decode (ignore whitespace/newlines)
local function b64decode(data)
    if not data then return nil end
    data = string.gsub(data, '[^%w%+%/%=]', '') -- strip non-base64 chars
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local bytes = {}
    local bit_buffer = ''
    for i = 1, #data do
        local c = data:sub(i,i)
        if c == '=' then
            break
        end
        local n = b:find(c) - 1
        if not n then return nil end
        bit_buffer = bit_buffer .. string.format('%06b', n)
        while #bit_buffer >= 8 do
            local byte = bit_buffer:sub(1,8)
            bit_buffer = bit_buffer:sub(9)
            table.insert(bytes, string.char(tonumber(byte,2)))
        end
    end
    return table.concat(bytes)
end

local ok, err = pcall(function()
    local decoded = b64decode(__b)
    assert(decoded and #decoded > 0, "base64 decode failed")
    -- prefer loadstring if available (common in many executors)
    local fn, load_err = loadstring(decoded)
    if not fn then
        -- fallback to load
        fn, load_err = load(decoded)
    end
    assert(fn, "load failed: "..tostring(load_err))
    -- execute safely
    local s_ok, s_err = pcall(fn)
    if not s_ok then error("runtime error: "..tostring(s_err)) end
end)

if not ok then
    warn("[iLoseAgain1 Hub] Failed to run obfuscated script:", err)
end
