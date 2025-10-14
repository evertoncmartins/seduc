-- Inicializa a simulação do Redis como uma tabela
local redis = {
    data = {},
    call = function(self, command, key, field, value)
        if command == "HSET" then
            if not self.data[key] then
                self.data[key] = {}
            end
            self.data[key][field] = value
        elseif command == "HGET" then
            return self.data[key] and self.data[key][field] or nil
        elseif command == "HINCRBY" then
            if self.data[key] and self.data[key][field] then
                self.data[key][field] = tostring(tonumber(self.data[key][field]) + tonumber(value))
            end
            return self.data[key][field]
        else
            return nil
        end
    end
}


-- Inicializa os dados do "Redis"
redis:call('HSET', 'produto:123', 'estoque', '100')
redis:call('HSET', 'produto:123', 'nome', 'Camiseta')
redis:call('HSET', 'produto:123', 'preco', '39.99')


-- Script para simular a compra de um produto
local produto_id = 'produto:123'  
local quantidade = 10           


-- Obtém o estoque atual do produto
local estoque = redis:call('HGET', produto_id, 'estoque')


-- Verifica se o estoque é insuficiente
if not estoque or tonumber(estoque) < quantidade then
    print('Erro: Estoque insuficiente!')
else
    -- Reduz o estoque
    redis:call('HINCRBY', produto_id, 'estoque', -quantidade)
    print('Compra realizada com sucesso!')
end


-- Exibe o estoque atualizado
print('Estoque atual:', redis:call('HGET', produto_id, 'estoque'))
