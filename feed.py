import yaml
import xml.etree.ElementTree as xml_tree

yaml_data = None
# open the feed.yaml
with open("feed.yaml", "r") as fd:
    yaml_data = yaml.safe_load(fd)
    
    # set up the attribute dictionary
    nms = "http://www.itunes.com/dtds/podcast-1.0.dtd"
    ctt = "http://purl.org/rss/1.0/modules/content"
    attrib_dict = {"version": "2.0",
                   "xmlns:itunes": nms,
                   "xmlns:content": ctt,
                   }
    rss_elem = xml_tree.Element("rss", attrib=attrib_dict)
    # create channel tag
    channel_se = xml_tree.SubElement(rss_elem, "channel")
    # next create the title tag and set text
    xml_tree.SubElement(channel_se, "title").text = yaml_data["title"]

    # link element - will have the url that we got when creating
    # the github page
    lnk_prefix = yaml_data['link']

    # other subelements
    xml_tree.SubElement(channel_se, "title").text = yaml_data["title"]
    xml_tree.SubElement(channel_se, "format").text = yaml_data["format"]
    xml_tree.SubElement(channel_se, "subtitle").text = yaml_data["subtitle"]
    xml_tree.SubElement(channel_se, "itunes:author").text = yaml_data["author"]
    xml_tree.SubElement(channel_se, "description").text = yaml_data["description"]
    # for image we need to add the attributes 
    # needs to be fully qualified href - so, include the lnk_prefix
    img_dict = {"href": f'{lnk_prefix}/{yaml_data["image"]}'}
    xml_tree.SubElement(channel_se, "itunes:image", img_dict)

    # other subelements
    xml_tree.SubElement(channel_se, "language").text = yaml_data["language"]
    xml_tree.SubElement(channel_se, "link").text = lnk_prefix
    
    # additional image - i.e. category subelement
    cat_dict = {"text": yaml_data["category"]}
    xml_tree.SubElement(channel_se, "itunes:category", cat_dict)

    # WE need to create item collection - section with several items
    # - each item being a podcast episode for instance present in the 
    #   feed.yaml 
    # since we have all audio in one format, let's just have a setting here
    aud_type = "audio/mpeg"

    for it in yaml_data["item"]:
        it_elem = xml_tree.SubElement(channel_se, "item")
        xml_tree.SubElement(it_elem, "title").text = it["title"]
        xml_tree.SubElement(it_elem, "itunes:author").text = yaml_data["author"]
        xml_tree.SubElement(it_elem, "description").text = it["description"]
        xml_tree.SubElement(it_elem, "pubDate").text = it["published"]
        xml_tree.SubElement(it_elem, "itunes:duration").text = it["duration"]
        # we need to create the enclosure subelement
        enc_dict = {"url": f'{lnk_prefix}/{it["file"]}',
                    "type": aud_type,
                    "length": it["length"]
                    }
        enc_se = xml_tree.SubElement(it_elem, "enclosure", enc_dict)
    # create the output tree
    op_tree = xml_tree.ElementTree(rss_elem)
    # write the podcast.xml file with setting the encoding and xml_declaration
    op_tree.write("podcast.xml", encoding="UTF-8", xml_declaration=True)

