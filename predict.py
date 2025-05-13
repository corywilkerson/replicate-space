from cog import BasePredictor, Input


class Predictor(BasePredictor):
    def setup(self):
        """Load the model into memory (no-op for this simple example)"""
        pass
        
    def predict(
        self,
        name: str = Input(description="Your name", default="world")
    ) -> str:
        """A simple hello-world function that runs on CPU"""
        return f"Hello, {name}! This is a CPU-based Replicate model."

