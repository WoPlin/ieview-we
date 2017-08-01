function installMenuItems() {
  browser.contextMenus.create({
    id: 'page',
    type: 'normal',
    title: browser.i18n.getMessage('contextMenu.page.label'),
    contexts: ['page', 'tab']
  });
  browser.contextMenus.create({
    id: 'link',
    type: 'normal',
    title: browser.i18n.getMessage('contextMenu.link.label'),
    contexts: ['link']
  });
}

installMenuItems();

configs.$load().then(() => {
  installMenuItems();
});
configs.$addObserver((aKey) => {
  if (aKey != 'contextMenu')
    return;

  if (configs.contextMenu) {
    installMenuItems();
  }
  else {
    browser.contextMenus.removeAll();
  }
});

browser.contextMenus.onClicked.addListener(function(aInfo, aTab) {
  let url = aInfo.linkUrl || aInfo.pageUrl || aTab.url;
  log('procesing url = ' + url);

  open(url);
});
