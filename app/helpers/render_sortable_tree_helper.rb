# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content
module RenderSortableTreeHelper
  module Render 
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
         
        node = options[:node]
        root_node = node.user.nodes.root
        klass = root_node == node ? 'root' : 'children'
        hidden = root_node == node  ? 'display:none' : nil     
        "
          <li id='#{ node.id }_#{options[:klass]}' class = '#{klass}'>
            <div class='item #{node.state}' style='#{hidden}'>
              <i class='handle'></i>
              #{ show_link }
              #{ controls }
            </div>
            #{ children }
          </li>  
        "
      end

      def show_link
        node = options[:node]  
        root = options[:root]
        ns   = options[:namespace]
        url  = h.url_for(ns + [node])
        title_field = options[:title]
        "<h4>#{ h.link_to(node.send(title_field), url) }</h4>"
      end

      def controls
        node = options[:node]
        if node.user.nodes.root != node
          if node.type == 'Task'
            visibility = { finish: true } 
            case node.state
            when 'active'
              visibility[:pause] = true
            when 'paused'
              visibility[:resume] = true
            when 'to_do'
              visibility[:start] = true
              visibility[:finish] = false
            when 'finished'
              visibility[:finish] = false
            end 
            "
            <div class='edit_task'>
              <a href= '/tasks/#{node.id}/edit'>Edit</a>
            </div>
            <div class='controls'>
              <a href= '/state_task?key=trash&task_id=#{node.id}'>X</a>
              <a href= '/state_task?key=inbox&task_id=#{node.id}'>inbox</a>
              <a href= '/state_task?key=next&task_id=#{node.id}'>Next</a>
              <a href= '/state_task?key=project&task_id=#{node.id}'>Project</a>
              <a href= '/state_task?key=waiting&task_id=#{node.id}'>waiting</a>
              <a href= '/state_task?key=someday&task_id=#{node.id}'>SomeDay</a>
              <a href= '/state_task?key=logBook&task_id=#{node.id}'>logbook</a>
            </div>
            <div class='state_control'>
                <a href= '#' class ='start' style = #{visibility[:start] == true ? 'display:block' : 'display:none' } >Start</a> 
                <a href= '#NewInterruptionModal' data-toggle='modal' style = #{visibility[:pause] == true ? 'display:block' : 'display:none' } class='pause'>Pause </a>
                <a href= '#'class ='resume' style = #{visibility[:resume] == true ? 'display:block' : 'display:none' }>Resume</a>
                <a href= '#'class ='finish' style = #{visibility[:finish] == true ? 'display:block' : 'display:none' }>Finish</a>
            </div>"
          else
            "<div class='edit_project'>
              <a href= '/projects/#{node.id}/edit'>Edit</a>
            </div>
            <div class='controls'>
              <a href= '/state_task?key=trash&task_id=#{node.id}'>X</a>
            </div>"  
          end
        end       
      end

      def children
        unless options[:children].blank?
          "<ol class='nested_set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end