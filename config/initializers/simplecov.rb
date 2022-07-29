# frozen_string_literal: true

if Rails.env.test?
  require 'simplecov'
  SimpleCov.start :rails do
    add_filter '/test/'
    add_filter '/lib/'
    add_filter '/app/jobs/'
    add_filter '/app/mailers/'
    add_filter '/app/channels/'
  end
end
