
# curl --silent https://www.welcometothejungle.co/companies?q=&hPP=30&idx=cms_companies_production&p=0&dFR%5Bcompany_size%5D%5B0%5D=Entre%2015%20et%2050%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B1%5D=%3C%2015%20salari%C3%A9s&dFR%5Bcompany_size%5D%5B2%5D=Entre%2050%20et%20250%20salari%C3%A9s&dFR%5Boffices%5D%5B0%5D=Paris&is_v=1 > companies.html

require 'open-uri' # Open an url
require 'nokogiri' # HTML ==> Nokogiri Document
require 'pry-byebug'

def parse_jobs_list(page_number)
  url = "https://azertyjobs.com/page/#{page_number}"
  file = "azjob.html"
  base_url = "https://azertyjobs.com/"

  html_file = open(url)
  html_doc = Nokogiri::HTML(html_file)
  doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
  html_doc.search('.master-presentation').first(2).each do |job|
    parse_job(job)
  end
end

def parse_job(job_doc)
  base_url = "https://azertyjobs.com"

  bck_picture = job_doc.search(".joboverview-image-background").last.attribute('style').value # difficile a utiliser
  logo_url = job_doc.search('.var-background > img').first.attribute('src').value #OK

  job_pres = job_doc.search('.presentation-job-title').first
    job_title = job_pres.text #OK
    job_path = job_pres.search('a').first.attribute('href').value #OK

  company = job_doc.search('.company').first
    company_path = company.attribute('href').value #OK
    company_name = company.text #OK

  job_short_desc = job_doc.search('.company-description-short').first.text #OK

  job_cat = job_doc.search('.tags-jobs').first
    job_tags = job_cat.search(".tags").map do |tag| #OK
      tag.text
    end

  job_city = job_doc.search('.location').first.text #OK

  company = {cname: company_name, cpath: company_path, clogourl: logo_url }
  job = { title: job_title, path: job_path, tags: job_tags, city: job_city, shortdesc: job_short_desc }

  job_url = "https://azertyjobs.com#{job_path}"

  job_details = parse_job_page(job_url)


  puts company
  puts job
  puts job_details

  binding.pry
end


def parse_job_page(job_url)
  html_file = open(job_url)
  html_doc = Nokogiri::HTML(html_file)
  job_doc = html_doc.search(".wrapper-content-job").first
  job_tags = job_doc.search(".wrapper-aside-job-page > ul").search("li > p").map do |tag|
    tag.text
  end

  job_desc = job_doc.search(".description-job > div")
    job_img_url = job_desc.first.search('img').attribute('src').value #OK à sauver
    job_desc_html = job_desc.inner_html
    job_desc_text = job_desc.text

  job_profile = job_doc.search(".description-profile > div")
    job_profile_html = job_profile.inner_html
    job_profile_text = job_profile.text

  job_details = { detailtags: job_tags, imgurl: job_img_url,
    deschtml: job_desc_html, desctext: job_desc_html,
    profilhtml: job_profile_html, profiltext: job_profile_text
  }

  return job_details
end

parse_jobs_list(1)

# job_url_test = "https://azertyjobs.com/job/lead-developpeur-ionic-ios-android-loisirsencheres-cdi-bordeaux"
# parse_job_page(job_url_test)


puts "hello"
