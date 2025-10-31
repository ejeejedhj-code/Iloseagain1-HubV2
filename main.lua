-- iLoseAgain1 Hub - Base64 loader (paste this as loader.lua)
local __b = [[__B64_STRING__]]

-- base64 decode (Lua 5.1 safe)
local function b64decode(data)
    data = string.gsub(data, '[^%w%+%/%=]', '')
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    local s = ''
    local n = 0
    local buf = 0
    for i = 1, #data do
        local c = data:sub(i,i)
        if c == '=' then break end
        local v = b:find(c) - 1
        buf = (buf << 6) + v
        n = n + 6
        while n >= 8 do
            n = n - 8
            local byte = (buf >> n) & 0xFF
            s = s .. string.char(byte)
            buf = buf & ((1 << n) - 1)
        end
    end
    return s
end

-- fallback shift/bit ops for environments w/o bitop
if not (bit32 and bit32.lshift) then
    -- provide simple bit helpers using arithmetic (works for bytes)
    local function shl(a,b) return a * (2^b) end
    local function shr(a,b) return math.floor(a / (2^b)) end
    local function band(a,b) return a % (2^32) >= b and b or (a%2^32)%b end
    -- we used << and >> and & in decode; to be safe, reimplement decode using arithmetic:
    local function b64decode_fallback(data)
        data = string.gsub(data, '[^%w%+%/%=]', '')
        local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        local out = {}
        local acc = 0
        local bits = 0
        for i = 1, #data do
            local c = data:sub(i,i)
            if c == '=' then break end
            local v = b:find(c) - 1
            acc = acc * 64 + v
            bits = bits + 6
            while bits >= 8 do
                bits = bits - 8
                local byte = math.floor(acc / (2^bits)) % 256
                table.insert(out, string.char(byte))
            end
        end
        return table.concat(out)
    end
    b64decode = b64decode_fallback
end

local ok, err = pcall(function()
    local decoded = b64decode(__b)
    assert(decoded and #decoded > 0, "decode failed")
    local f, e = loadstring(decoded)
    if not f then error("loadstring failed: "..tostring(e)) end
    f()
end)

if not ok then
    warn("[iLoseAgain1 Hub] Failed to run obfuscated script:", err)
end
