local tilemap = Class {}

function tilemap:init(data)

	-- only tileset we care about
	local tileset = data.tilesets[1]

	-- get image width/height for texture
	self.texture_width = tileset.imagewidth
	self.texture_height = tileset.imageheight

	-- height/width of individual tiles
	self.tile_width = tileset.tilewidth
	self.tile_height = tileset.tileheight

	-- pixel margins between inviduual tiles to prevent glitches
	self.margin = tileset.margin

	-- handle only first layer
	local layer = data.layers[1]

	-- width/height in tiles of the actual map
	self.width = layer.width
	self.height = layer.height

	-- tile data, flat table of ids
	self.tiles = data

end

function tilemap:update()

	local tile_map = self
	for i=1, #self.tiles do

		-- this is not even
		local x = (i % tile_map.width) * tile_map.tile_width
		local y = (i / tile_map.height) * tile_map.tile_height

		local res = tile_resources[tile_map.data[i]]

		if res then
			-- still awful
			lg.draw(res, x, y)
		end

	end

end

function tilemap:draw()

end

return tilemap
