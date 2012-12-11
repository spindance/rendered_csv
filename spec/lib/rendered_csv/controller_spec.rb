require 'spec_helper'
require 'rendered_csv/controller'

describe RenderedCsv::Controller do
  before do
    @controller = Object.new
    @controller.extend(RenderedCsv::Controller)
  end

  describe 'when asked to render a CSV file' do
    before do
      @request = mock()
      @env = mock()
      @request.stubs(:env).returns(@env)
      @env.stubs('[]')
      @controller.stubs(:request).returns(@request)

      @headers = mock()
      @headers.stubs('[]')
      @headers.stubs('[]=')
      @controller.stubs(:headers).returns(@headers)
    end
    describe 'with a template' do
      it 'should render the correct template' do
        @controller.expects(:render).with('index', {:layout => false})
        @controller.render_csv('widgets', 'index')
      end
    end
    describe 'without a template' do
      it 'should render' do
        @controller.expects(:render).with({:layout => false})
        @controller.render_csv('widgets')
      end
    end
  end

  describe 'when asked to render a CSV file' do
    before do
      @request = mock()
      @env = mock()
      @request.stubs(:env).returns(@env)
      @env.stubs('[]')
      @controller.stubs(:request).returns(@request)

      @headers = mock()
      @headers.stubs('[]')
      @headers.stubs('[]=')
      @controller.stubs(:headers).returns(@headers)

      @controller.stubs(:render)
    end
    describe 'with a filename' do
      it 'should set the filename in the header' do
        @headers.expects('[]=').with("Content-Disposition", "attachment; filename=\"widgets.csv\"")
        @controller.render_csv('widgets')
      end
    end
    describe 'without a filename' do
      it 'should set the filename in the header' do
        @controller.expects(:params).returns({:action => 'index'})
        @headers.expects('[]=').with("Content-Disposition", "attachment; filename=\"index.csv\"")
        @controller.render_csv
      end
    end
  end

  describe 'when asked to render a CSV file' do
    before do
      @controller.stubs(:params).returns({:action => 'index'})

      @request = mock()
      @env = mock()
      @request.stubs(:env).returns(@env)
      @env.stubs('[]')
      @controller.stubs(:request).returns(@request)

      @headers = mock()
      @headers.stubs('[]')
      @headers.stubs('[]=').with("Content-Disposition", "attachment; filename=\"index.csv\"")
      @controller.stubs(:headers).returns(@headers)

      @controller.stubs(:render)
    end
    describe 'with Content-Type already set' do
      it 'should not set the Content-Type in the header' do
        @headers.expects('[]').with("Content-Type").returns('application/csv')
        @controller.render_csv
      end
    end
    describe 'with Content-Type not set' do
      it 'should set the Content-Type in the header' do
        @headers.expects('[]=').with("Content-Type", 'text/csv')
        @controller.render_csv
      end
    end
  end

  describe 'when asked to render a CSV file' do
    before do
      @controller.stubs(:params).returns({:action => 'index'})

      @request = mock()
      @env = mock()
      @request.stubs(:env).returns(@env)
      @controller.stubs(:request).returns(@request)

      @headers = mock()
      @controller.stubs(:headers).returns(@headers)

      @controller.stubs(:render)
    end
    describe 'for IE browser' do
      before do
        @env.stubs('[]').with('HTTP_USER_AGENT').returns('msie')
      end
      it 'should set the correct headers' do
        @headers.expects('[]=').with("Pragma", 'public')
        @headers.expects('[]=').with("Content-Type", "text/plain")
        @headers.expects('[]=').with("Cache-Control", 'no-cache, must-revalidate, post-check=0, pre-check=0')
        @headers.expects('[]=').with("Content-Disposition", "attachment; filename=\"index.csv\"")
        @headers.expects('[]=').with("Expires", '0')
        @controller.render_csv
      end
    end
    describe 'for non-IE browser' do
      before do
        @env.stubs('[]').with('HTTP_USER_AGENT').returns('mozilla')
        @headers.stubs('[]').returns(nil)
      end
      it 'should set the correct headers' do
        @headers.expects('[]=').with("Content-Type", "text/csv")
        @headers.expects('[]=').with("Content-Disposition", "attachment; filename=\"index.csv\"")
        @controller.render_csv
      end
    end
  end

end
