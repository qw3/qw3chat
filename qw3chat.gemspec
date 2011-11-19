# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "qw3chat/version"

Gem::Specification.new do |s|
  s.name        = "qw3chat"
  s.version     = Qw3chat::VERSION
  s.authors     = ["QW3", "Marcelo Theodoro"]
  s.email       = ["contato@qw3.com.br"]
  s.homepage    = "http://www.qw3.com.br"
  s.summary     = %q{Componente de atendimento online da plataforma QW3.}
  s.description = %q{Administra atendimentos entre cliente e empresa.}
  
  s.add_dependency 'devise'
  s.add_dependency 'cancan'
  s.add_dependency 'brstring'
  
  #s.rubyforge_project = "qw3chat"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
