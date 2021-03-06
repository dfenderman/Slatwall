/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/

jQuery(document).ready(function() {
    var skuCount = jQuery('tr[id^="Sku"]').length;
    $("#addSKU").click(function() {
        var current = jQuery('tr[id^="Sku"]').length;
        current++;
        var $newSKU= jQuery( "#tableTemplate tbody>tr:last" ).clone(true);
        $newSKU.children("td").children("input").each(function(i) {
            var $currentElem= $(this);
            if ($currentElem.attr("type") != "radio") {
                $currentElem.attr("name", "skus[" + current + "]." + $currentElem.attr("name"));
            }
        });
        $newSKU.children("td").children("select").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name","skus["+current+"]."+$currentElem.attr("name"));
        });
        $('#remSKU').attr('style','');
        $('#skuTable > tbody:last').append($newSKU);
        $newSKU.attr("id","Sku" + current);
        // add stripe to row
        if(current % 2 == 1) {
            $newSKU.addClass("alt");
        }
    });
    
    $('#remSKU').click(function() {
        var num = jQuery('tr[id^="Sku"]').length;
        $('#Sku' + num).remove();
        // can't remove more skus than were originally present
        if(num-1 == skuCount) {
            jQuery('#remSKU').attr('style','display:none;');
        }
    });
	
    $("#addImage").click(function() {
        var current = jQuery('input.imageid').length;
        current++;
        var $newImage= jQuery( "#imageUploadTemplate" ).clone(true);
        $newImage.children("dd").children("input").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name", "images[" + current + "]." + $currentElem.attr("name"));
            if ($currentElem.attr("type") == "hidden") {
                $currentElem.attr("class", "imageid");
            }
        });
        $newImage.children("dd").children("select").each(function(i) {
            var $currentElem= $(this);
            $currentElem.attr("name","images["+current+"]."+$currentElem.attr("name"));
        });
        $newImage.children("dd").find("textarea").each(function(i) {
			var $currentElem = $(this);
			$currentElem.attr("name","images["+current+"]."+$currentElem.attr("name"));
			$currentElem.attr("id",$currentElem.attr("id") + current);
			$currentElem.addClass("wysiwyg").addClass("Basic");
        });
		if($('.alternateImageUpload').length == 0) {
			$('.buttons:last').before($newImage);
		} else {
			$('.alternateImageUpload:last').after($newImage);	
		}
		$newImage.children("dd").find("textarea.wysiwyg").each(function(i){
			setRTE($(this));
		});
        $newImage.removeAttr("id");
		$newImage.attr("class","alternateImageUpload");
    });
	
    $(".uploadImage").colorbox({
        onComplete: function() {
			// upload button is disabled unless file field is filled
            $('input.imageFile').change(function(){
                    if($(this).val()) {
                        $('input.uploadImage').removeAttr('disabled');
                    } 
            });         
        }
    });
});
