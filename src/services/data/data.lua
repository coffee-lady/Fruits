local Constants = require('src.constants.constants')

local AppConst = Constants.app

local DataService = {}

DataService.data_file = sys.get_save_file(AppConst.app_name, AppConst.data_filename)

function DataService:save(data)
    sys.save(self.data_file, data)
end

function DataService:get_all()
    local data = sys.load(self.data_file)

    return data
end

return DataService
