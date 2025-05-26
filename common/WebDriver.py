from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager
from webdriver_manager.microsoft import EdgeChromiumDriverManager
import os
import stat
import platform

def get_driver_path_with_browser(browser_name):
    system = platform.system()
    if browser_name.lower() == 'chrome':
        driver_path = ChromeDriverManager().install()
        if system == 'Windows':
            driver_path = os.path.join(os.path.dirname(driver_path), 'chromedriver.exe')
        else:
            driver_path = os.path.join(os.path.dirname(driver_path), 'chromedriver')
        os.chmod(driver_path, stat.S_IRWXU)
    elif browser_name.lower() == 'firefox':
        driver_path = GeckoDriverManager().install()
    elif browser_name.lower() == 'edge':
        driver_path = EdgeChromiumDriverManager().install()
    else:
        raise ValueError(f"Navegador {browser_name} não suportado.")
    print(f"Driver path for {browser_name}: {driver_path}")
    return driver_path
