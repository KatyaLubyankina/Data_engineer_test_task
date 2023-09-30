import re
from typing import List

import matplotlib.pyplot as plt
import nltk
import pymorphy2
from nltk.corpus import stopwords
from selenium import webdriver
from selenium.webdriver.common.by import By
from wordcloud import WordCloud


class DzenWordCloud:
    """Class to parse rubric from dzen.ru and generate wordcloud"""

    def __init__(self, rubric: str = "games") -> None:
        """Initiate class object with specific rubric

        Args:
            rubric (str): rubric in dzen.ru
        """
        self.url = f"https://dzen.ru/news/rubric/{rubric}?issue_tld=ru"

    def load_website(self) -> webdriver.chrome.webdriver.WebDriver:
        """
        Connect to website (self.url) via Chrome.

        Returns:
            WebDriver to drive a browser.
        """
        options = webdriver.ChromeOptions()
        options.add_argument("--headless")
        driver = webdriver.Chrome(options=options)
        driver.get(self.url)
        return driver

    def get_words_from_articles(self, content: List[str]) -> List[str]:
        """Get all words from list of string.

        Remove punctuation, change upper case to lower and
        split text into words.

        Args:
            content (List[str]): list with texts.

        Returns:
            List[str]: list of words from all texts.
        """
        words = []
        for item in content:
            article = item.get_attribute("innerHTML").lower()
            article = re.sub(r"&nbsp;|[!?:,;.]", " ", article)
            words.extend(article.split(" "))
        return words

    def parse_content(self, driver: webdriver.chrome.webdriver.WebDriver) -> List[str]:
        """Get titles and articles from self.url.

        Args:
            driver (webdriver.chrome.webdriver.WebDriver): WebDriver to drive a browser.

        Returns:
            list of all words from title and short article.
        """
        class_names = ["mg-card__link", "mg-card__annotation"]
        texts = []
        for class_name in class_names:
            text = driver.find_elements(By.CLASS_NAME, class_name)
            texts.extend(self.get_words_from_articles(text))
        return texts

    def normalize_words(self, words: List[str]) -> List[str]:
        """Convert words to normal form via pymorphy2.

        Args:
            words (List[str]): list with words.

        Returns:
            List[str]: list of words in normal form.
        """
        morph = pymorphy2.MorphAnalyzer()
        words_normal_form = [morph.parse(word)[0].normal_form for word in words]
        return words_normal_form

    def remove_stop_words(self, words_normal_form: List[str]) -> List[str]:
        """Remove all stop words in russian (such as "и", "в", "не").

        Args:
            words_normal_form (List[str]): list with words in normal form.

        Returns:
            List[str]: list of words without stop words
        """
        nltk.download("stopwords")
        stop_words = set(stopwords.words("russian"))
        filtered_words = [word for word in words_normal_form if word not in stop_words]
        return filtered_words

    def generate_wordcloud(self):
        """Generate wordcloud for titles and articles."""
        driver = self.load_website()
        content_words = self.parse_content(driver)
        normalized_words = self.normalize_words(content_words)
        filtered_articles = self.remove_stop_words(normalized_words)
        text = " ".join(filtered_articles)
        wc = WordCloud(width=1000, height=1000, max_words=50).generate(text)
        plt.imshow(wc, interpolation="bilinear")
        plt.axis("off")
        plt.show()


if __name__ == "__main__":
    obj = DzenWordCloud()
    obj.generate_wordcloud()
