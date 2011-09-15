# -*- encoding : utf-8 -*-
require "qw3chat/version"

module Qw3chat

  class Qw3chat < Rails::Engine
    config.autoload_paths << File.expand_path("../app", __FILE__)
  end
  
end