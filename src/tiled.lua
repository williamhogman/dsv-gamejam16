local tilemap = {}

function tilemap:new(data)

	local new_obj = {}

	-- only tileset we care about
	local tileset = data.tilesets[1]

	-- get image width/height for texture
	new_obj.texture_width = tileset.imagewidth
	new_obj.texture_height = tileset.imageheight

	-- height/width of individual tiles
	new_obj.tile_width = tileset.tilewidth
	new_obj.tile_height = tileset.tileheight

	-- pixel margins between inviduual tiles to prevent glitches
	new_obj.margin = tileset.margin

	-- handle only first layer
	local layer = data.layers[1]

	-- width/height in tiles of the actual map
	new_obj.width = layer.width
	new_obj.height = layer.height

	-- tile data, flat table of ids
	new_obj.data = data

	-- prototype shit
	setmetatable(new_obj, self)
	self.__index = self

	return new_obj

end

function tilemap:update()

	for i=1, #tilemap do

	end

end

function tilemap:draw()

end

return tilemap
