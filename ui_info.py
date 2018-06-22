# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ui_info.ui'
#
# Created by: PyQt5 UI code generator 5.5.1
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_info(object):
    def setupUi(self, info):
        info.setObjectName("info")
        info.resize(818, 724)
        self.verticalLayout = QtWidgets.QVBoxLayout(info)
        self.verticalLayout.setObjectName("verticalLayout")
        self.buttonHome = QtWidgets.QToolButton(info)
        icon = QtGui.QIcon()
        icon.addPixmap(QtGui.QPixmap(":/icons/icons/go-home.png"), QtGui.QIcon.Normal, QtGui.QIcon.Off)
        self.buttonHome.setIcon(icon)
        self.buttonHome.setIconSize(QtCore.QSize(22, 22))
        self.buttonHome.setObjectName("buttonHome")
        self.verticalLayout.addWidget(self.buttonHome)
        self.webView = QtWebKitWidgets.QWebView(info)
        self.webView.setUrl(QtCore.QUrl("about:blank"))
        self.webView.setObjectName("webView")
        self.verticalLayout.addWidget(self.webView)

        self.retranslateUi(info)
        QtCore.QMetaObject.connectSlotsByName(info)

    def retranslateUi(self, info):
        _translate = QtCore.QCoreApplication.translate
        info.setWindowTitle(_translate("info", "Info"))
        self.buttonHome.setToolTip(_translate("info", "load selected dataset"))
        self.buttonHome.setStatusTip(_translate("info", "load selected dataset"))
        self.buttonHome.setText(_translate("info", "OSM"))

from PyQt5 import QtWebKitWidgets
from . import resources_rc
