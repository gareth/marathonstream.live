class StreamsController < ApplicationController
  include Channelable

  before_action :set_stream, only: %i[show edit update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  # GET /streams or /streams.json
  def index
    @streams = authorize policy_scope(twitch_channel.streams)
  end

  # GET /streams/1 or /streams/1.json
  def show; end

  # GET /streams/new
  def new
    @stream = authorize twitch_channel.streams.build
  end

  # GET /streams/1/edit
  def edit; end

  # POST /streams or /streams.json
  def create
    @stream = authorize twitch_channel.streams.build(stream_params)

    respond_to do |format|
      if @stream.save
        format.html { redirect_to stream_url(@stream), notice: "Stream was successfully created." }
        format.json { render :show, status: :created, location: @stream }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /streams/1 or /streams/1.json
  def update
    respond_to do |format|
      if @stream.update(stream_params)
        format.html { redirect_to stream_url(@stream), notice: "Stream was successfully updated." }
        format.json { render :show, status: :ok, location: @stream }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stream.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streams/1 or /streams/1.json
  def destroy
    @stream.destroy

    respond_to do |format|
      format.html { redirect_to streams_url, notice: "Stream was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stream
    @stream = authorize twitch_channel.streams.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stream_params
    params.require(:stream).permit(:title, :starts_at, :initial_duration)
  end
end
