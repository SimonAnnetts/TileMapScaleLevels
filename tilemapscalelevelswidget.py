from .ui_tilemapscalelevelswidget import Ui_TileMapScaleLevelsDockWidget
from PyQt5 import QtWidgets

class TileMapScaleLevelsDockWidget(QtWidgets.QDockWidget, Ui_TileMapScaleLevelsDockWidget):

    def __init__(self):
        super(TileMapScaleLevelsDockWidget, self).__init__()
        
        self.setupUi(self)
        self.show()
