var currentTime=new Date()
var month=currentTime.getMonth()+ 1
var day=currentTime.getDate()- 1;var year=currentTime.getFullYear()
var processLeaderboard=function(data){var ROIwidth,ROI,prevROI;$.each(data,function(i,item){if(i==0){ROIwidth=100;ROI=prevROI=parseFloat(item.member.roi.period_1_month);}else{ROI=parseFloat(item.member.roi.period_1_month);ROIwidth=(ROI/prevROI)*100;}
var row="<div class='leaderboard-row clear'><div class='mugshot'><a href='http://community.tradeking.com/members/"+item.member.member_url+"' target='_blank'><img src='http://community.tradeking.com"+item.member.avatar.public_filename+"'></a></div><div class='leaderboard-percentage'><div class='bar' style='width:"+parseInt(ROIwidth)+"%'>"+ROI+"%</div><div class='leaderboard-name'><a href='http://community.tradeking.com/members/"+item.member.member_url+"' target='_blank'>"+item.member.name+"</a></div></div></div>";$("#leaderboard-rows").append(row);if(i==2)return false;});$("#leaderboard-date").html(month+"/"+ day+"/"+ year);}
$(document).ready(function(){$.ajax({dataType:'jsonp',jsonp:'processLeaderboard',url:'http://community.tradeking.com/leaderboard.js?callback=?'});mod=(parseInt(day)%5);$.get("/media/php/controller.php",{play:mod},function(featuredPlay){$("#featured-play-content").html(featuredPlay);jQuery('#featured-play-content').jcarousel();});$(".intelligence-reports select").change(function(){window.open($(this).attr("value"));});$('#overby-feed-home').gFeed({url:'http://community.tradeking.com/members/optionsguy/blogs.atom',max:1,title:null});$('#network-feed-home').gFeed({url:'http://community.tradeking.com/blogs.atom',max:3,title:null});});