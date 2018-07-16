#/***************************************************************************
# TileMapScalePlugin
#
# Let you add tiled datasets (GDAL WMS) and shows them in the correct scale.
#                             -------------------
#        begin                : 2014-03-03
#        copyright            : (C) 2014 by Matthias Ludwig - Datalyze Solutions
#        email                : m.ludwig@datalyze-solutions.com
# ***************************************************************************/
#
#/***************************************************************************
# *                                                                         *
# *   This program is free software; you can redistribute it and/or modify  *
# *   it under the terms of the GNU General Public License as published by  *
# *   the Free Software Foundation; either version 2 of the License, or     *
# *   (at your option) any later version.                                   *
# *                                                                         *
# ***************************************************************************/

# CONFIGURATION
PLUGIN_UPLOAD = $(CURDIR)/plugin_upload.py

QGISDIR=.qgis2

# Makefile for a PyQGIS plugin

# translation
SOURCES = tilemapscaleplugin.py ui_info.py __init__.py tilemapscalelevelswidget.py ui_tilemapscalelevelswidget.py
#TRANSLATIONS = i18n/tilemapscaleplugin_en.ts
TRANSLATIONS =

# global

PLUGINNAME = TileMapScaleLevels

PY_FILES = tilemapscaleplugin.py __init__.py tilemapscalelevelswidget.py

EXTRAS = icon.png metadata.txt README.html

UI_FILES = ui_info.py ui_tilemapscalelevelswidget.py ui_hud.py

RESOURCE_FILES = resources_rc.py

HELP = help/build/html

EXTRA_FOLDERS = tms datasets utils icons

default: compile

compile: $(UI_FILES) $(RESOURCE_FILES)

%_rc.py : %.qrc
	pyrcc4 -o $*_rc.py  $<

%.py : %.ui
	pyuic4 -o $@ $<

%.qm : %.ts
	lrelease $<

# The deploy  target only works on unix like operating system where
# the Python plugin directory is located at:
# $HOME/$(QGISDIR)/python/plugins
deploy: compile doc transcompile
	mkdir -p $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	cp -vf $(PY_FILES) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	cp -vf $(UI_FILES) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	cp -vf $(RESOURCE_FILES) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	cp -vf $(EXTRAS) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	#cp -vfr i18n $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)
	cp -vfr $(HELP) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/help
	cp -vfr $(EXTRA_FOLDERS) $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/

# The dclean target removes compiled python files from plugin directory
# also delets any .svn entry
dclean:
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME) -iname "*.pyc" -delete
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME) -iname ".svn" -prune -exec rm -Rf {} \;
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/icons -iname "*.svg" -type f -delete
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/icons -iname "*.xcf" -type f -delete
	# delete unfree datasets
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/datasets -not -iname "*osm*" -type f -delete
	find $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)/datasets -iname "*aux.xml" -type f -delete

# The derase deletes deployed plugin
derase:
	rm -Rf $(HOME)/$(QGISDIR)/python/plugins/$(PLUGINNAME)

# The zip target deploys the plugin and creates a zip file with the deployed
# content. You can then upload the zip file on http://plugins.qgis.org
zip: deploy dclean
	rm -f $(PLUGINNAME).zip
	cd $(HOME)/$(QGISDIR)/python/plugins; zip -9r $(CURDIR)/$(PLUGINNAME).zip $(PLUGINNAME)

# Create a zip package of the plugin named $(PLUGINNAME).zip.
# This requires use of git (your plugin development directory must be a
# git repository).
# To use, pass a valid commit or tag as follows:
#   make package VERSION=Version_0.3.2
package: compile
		rm -f $(PLUGINNAME).zip
		git archive --prefix=$(PLUGINNAME)/ -o $(PLUGINNAME).zip $(VERSION)
		echo "Created package: $(PLUGINNAME).zip"

upload: zip
	$(PLUGIN_UPLOAD) $(PLUGINNAME).zip

# transup
# update .ts translation files
transup:
	pylupdate4 Makefile

# transcompile
# compile translation files into .qm binary format
transcompile: $(TRANSLATIONS:.ts=.qm)

# transclean
# deletes all .qm files
transclean:
	rm -f i18n/*.qm

clean:
	rm $(UI_FILES) $(RESOURCE_FILES)

# build documentation with sphinx
doc:
	cd help; make html
