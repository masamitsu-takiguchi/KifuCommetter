# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  # GET /documents/ReadMe.html
  def readme
  end

  # GET /documents/PoliciesAndThanks.html
  def policies_and_thanks
  end

  # GET /documents/GettingStarted.html
  def getting_started
  end

  # GET /documents/BugReport.html
  def bug_report
  end

  # GET /document/ToDo.html
  def todo
  end

  # GET /document/Commits.html
  def commits
    url = URI("http://github.com/api/v2/json/commits/list/" + 
              "sandmark/KifuCommetter/master") # GitHub の API
    http = Net::HTTP.new url.host
    response = http.get url.request_uri
    hash = ActiveSupport::JSON.decode response.body
    @commits = hash["commits"]
  end
end
