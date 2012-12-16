#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'test/unit'
require File.join(File.dirname(__FILE__), 'setup_variant')
require 'json/pointer'

class TestJSONPointer < Test::Unit::TestCase
  include JSON

  # given by draft-ietf-appsawg-json-pointer-07
  def setup
    jsonstr = %q<{ "foo": ["bar", "baz"], "": 0, "a/b": 1, "c%d": 2, "e^f": 3, "g|h": 4, "i\\\\j": 5, "k\"l": 6, " ": 7, "m~n": 8 }>
    @json = JSON.parse(jsonstr)
  end

  def test_rfc_pattern_0
  end

  def test_rfc_pattern_1
    obj = JSON::Pointer.find('/foo', @json)
    assert_equal(2, obj.size);
    assert_equal('bar', obj[0]);
    assert_equal('baz', obj[1]);
  end

  def test_rfc_pattern_2
    assert_equal('bar', JSON::Pointer.find('/foo/0', @json))
  end

  def test_rfc_pattern_3
    assert_equal(0, JSON::Pointer.find('/', @json))
  end

  def test_rfc_pattern_4
    assert_equal(1, JSON::Pointer.find('/a~1b', @json))
  end

  def test_rfc_pattern_5
    assert_equal(2, JSON::Pointer.find('/c%d', @json))
  end

  def test_rfc_pattern_6
    assert_equal(3, JSON::Pointer.find('/e^f', @json))
  end

  def test_rfc_pattern_7
    assert_equal(4, JSON::Pointer.find('/g|h', @json))
  end

  def test_rfc_pattern_8
    assert_equal(5, JSON::Pointer.find('/i\\\\j', @json))
  end

  def test_rfc_pattern_9
    assert_equal(6, JSON::Pointer.find('/k\"l', @json))
  end

  def test_rfc_pattern_10
    assert_equal(7, JSON::Pointer.find('/ ', @json))
  end

  def test_rfc_pattern_11
    assert_equal(8, JSON::Pointer.find('/m~0n', @json))
  end
end

