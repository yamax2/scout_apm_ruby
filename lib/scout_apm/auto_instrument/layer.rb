
module ScoutApm
  def self.AutoInstrument(name, backtrace = nil)
    request = ScoutApm::RequestManager.lookup

    begin
      layer = ScoutApm::Layer.new('AutoInstrument', name)
      layer.backtrace = backtrace

      request.start_layer(layer)
      started_layer = true

      result = yield
    ensure
      request.stop_layer if started_layer
    end

    return result
  end
end
