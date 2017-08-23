class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(created_at:  (Time.now - 24.hours)..Time.now)
    @comments = Comment.joins(:posts)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(post_id: @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js   { render :partial => "posts/index" }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        if request.xhr?
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        end
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def recent
    @posts = Post.all
  end

  def parse
    require 'open-uri'
    require 'nokogiri'
    require 'json'

    url_ua_football = 'https://www.ua-football.com/'
    html_ua_football = open(url_ua_football)

    doc_ua_football = Nokogiri::HTML(html_ua_football)
    @ua_football = []
    doc_ua_football.css('#allnews li').each do |showing|
      title_el = showing.at_css('a')
      title = title_el.text.strip
      link = showing.at_css('a').attr('href')
      @ua_football.push(
        title: title,
        link: link,
      )
    end

    url_football_ua = 'http://football.ua/'
    html_football_ua = open(url_football_ua)

    doc_football_ua = Nokogiri::HTML(html_football_ua)
    @football_ua = []
    doc_football_ua.css('#ctl00_columnRight li').each do |showing|
      title_el = showing.at_css('a')
      title = title_el.try(:text).try(:strip) || title_el.try(:strip)
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      end
      @football_ua.push(
        title: title,
        link: link,
      )
    end

    url_football24 = 'https://football24.ua/'
    html_football24 = open(url_football24)

    doc_football24 = Nokogiri::HTML(html_football24)
    @football24 = []
    doc_football24.css('#news-list-module li').each do |showing|
      title_el = showing.at_css('a .title')
      if title_el = showing.at_css('a .title')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      end
      @football24.push(
        title: title,
        link: 'https://football24.ua/'+link,
      )
    end

    url_eurosport = 'http://www.eurosport.ru/football/'
    html_eurosport = open(url_eurosport)

    doc_eurosport = Nokogiri::HTML(html_eurosport)
    @eurosport = []
    doc_eurosport.css('.storylist-latest-content .storylist-container-latest').each do |showing|
      title_el = showing.at_css('.storylist-latest__main-title a')
      title = title_el.text.strip
      if showing.at_css('.storylist-latest__main-title a')
        link = showing.at_css('.storylist-latest__main-title a').attr('href')
      end
      @eurosport.push(
        title: title,
        link: 'http://www.eurosport.ru/'+link,
      )
    end

    url_dynamo = 'http://dynamo.kiev.ua/'
    html_dynamo = open(url_dynamo)

    doc_dynamo = Nokogiri::HTML(html_dynamo)
    @dynamo = []
    doc_dynamo.css('#news-widget .news li').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @dynamo.push(
        title: title,
        link: link,
      )
    end

    url_terrikon = 'http://terrikon.com/football/'
    html_terrikon = open(url_terrikon)

    doc_terrikon = Nokogiri::HTML(html_terrikon)
    @terrikon = []
    doc_terrikon.css('.news:nth-child(even) dd').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @terrikon.push(
        title: title,
        link: 'http://terrikon.com'+link,
      )
    end

    url_footboom = 'https://www.footboom.com/'
    html_footboom = open(url_footboom)

    doc_footboom = Nokogiri::HTML(html_footboom)
    @footboom = []
    doc_footboom.css('#news-feed-tab-news .b-list-item').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @footboom.push(
        title: title,
        link: link,
      )
    end

    url_zbirna = 'http://zbirna.com/'
    html_zbirna = open(url_zbirna)

    doc_zbirna = Nokogiri::HTML(html_zbirna)
    @zbirna = []
    doc_zbirna.css('aside .recent-news-oranges').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @zbirna.push(
        title: title,
        link: link,
      )
    end

    url_sportarena = 'https://sportarena.com/football/'
    html_sportarena = open(url_sportarena)

    doc_sportarena = Nokogiri::HTML(html_sportarena)
    @sportarena = []
    doc_sportarena.css('.list-news .list-news-item').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @sportarena.push(
        title: title,
        link: link,
      )
    end

    url_tribuna = 'https://ua.tribuna.com/news/football/'
    html_tribuna = open(url_tribuna)

    doc_tribuna = Nokogiri::HTML(html_tribuna)
    @tribuna = []
    doc_tribuna.css('.short-news p').each do |showing|
      title_el = showing.at_css('a')
      if title_el = showing.at_css('a')
        title = title_el.text.strip
      end
      if showing.at_css('a')
        link = showing.at_css('a').attr('href')
      else 
        link = "none"
      end
      @tribuna.push(
        title: title,
        link: 'https://ua.tribuna.com'+link,
      )
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:url, :title, :content, :user_id, :code, :rating, :domain, {photos: []})
    end
end
