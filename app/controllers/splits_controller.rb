class SplitsController < ApplicationController
  self.resource = Split
  self.serializer_class = SplitSerializer
end
