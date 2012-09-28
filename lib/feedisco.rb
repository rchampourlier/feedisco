#!/usr/bin/ruby

# Feedisco
#
# Built from Feedbag
#   - replaced Hpricot by Nokogiri
# 	- improved discovery to check on /rss and /atom URIs
# 	- removed the global variables
#
# Copyright  Axiombox (c) 2008
#            David Moreno <david@axiombox.com> (c) 2008
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "rubygems"
require "nokogiri"
require "open-uri"
require "net/http"

$LOAD_PATH.unshift(File.dirname(__FILE__))

module Feedisco
  def self.feed_content_types
    [
      'application/x.atom+xml',
      'application/atom+xml',
      'application/xml',
      'text/xml',
      'application/rss+xml',
      'application/rdf+xml',
    ]
  end
end

require 'feedisco/discovery'

Feedisco.extend Feedisco::Discovery

$LOAD_PATH.shift
